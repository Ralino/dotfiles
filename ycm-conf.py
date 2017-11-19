# Partially stolen from https://bitbucket.org/mblum/libgp/src/2537ea7329ef/.ycm_extra_conf.py
import os
import logging
import ycm_core

relative_to_config = False
find_compilation_database = True
global_compilation_database_folder = ''
use_neighbor_file = True
container_root = '' #empty if not built in container
bound_folders   = []

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
    '-Wall',
    '-Wextra',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    # THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
    # language to use when compiling headers. So it will guess. Badly. So C++
    # headers will be compiled as C headers. You don't want that so ALWAYS specify
    # a "-std=<something>".
    # For a C project, you would set this to something like 'c99' instead of
    # 'c++11'.
    '-std=c++14',
    # ...and the same thing goes for the magic -x option which specifies the
    # language that the files to be compiled are written in. This is mostly
    # relevant for c++ headers.
    # For a C project, you would set this to 'c' instead of 'c++'.
    '-x', 'c++',
    # This path will only work on OS X, but extra paths that don't exist are not
    # harmful
    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',
    '-isystem', '/usr/local/include/eigen3',
    '-isystem', '/lib/clang/3.9.0/include',
    '-I', 'include',
    '-I', '../include',
    '-I', './',
    '-I.',
]


if global_compilation_database_folder:
  global_database = ycm_core.CompilationDatabase( global_compilation_database_folder )
else:
  global_database = None


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )
      if len(list(filter(new_flag.startswith, bound_folders))) == 0:
        new_flag = container_root + new_flag

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = os.path.join(working_directory, flag[ len( path_flag ): ])
        if len(list(filter(path.startswith, bound_folders))) == 0:
          path = container_root + path
        new_flag = path_flag + path
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def FindSource(headername, parentdir):
  for f in os.listdir(parentdir):
    splitted = os.path.splitext(f)
    if (splitted[1] == '.cpp' or splitted[1] == '.c') and splitted[0] == headername:
      return os.path.abspath(parentdir + os.path.sep + f)
    if os.path.isdir(parentdir + os.path.sep + f):
      srcfile = FindSource(headername, parentdir + os.path.sep + f)
      if srcfile:
        return srcfile
  return ''


def FlagsForFile( filename ):
  logger = logging.getLogger(__name__)
  logger.info('Filename: %s', filename)
  database = global_database
  compilation_database_folder = global_compilation_database_folder
  curdir = None
  if find_compilation_database and not database:
    curdir = os.path.dirname(os.path.abspath(filename))
    while curdir != "/":
      if os.path.exists(curdir + os.path.sep + "compile_commands.json"):
        database = ycm_core.CompilationDatabase(curdir)
        compilation_database_folder = curdir
        logger.info('Compilation database folder: %s', compilation_database_folder)
        break
      curdir = os.path.dirname(curdir)

  compilation_info = None
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile(os.path.abspath(filename))
    if len(compilation_info.compiler_flags_) == 0:
      # File is not in compilation database
      splitted = os.path.splitext(filename)
      if splitted[1] == '.h' or splitted[1] == '.hpp':
        # Search subdirectories of compilation database
        srcfile = FindSource(os.path.basename(splitted[0]), compilation_database_folder)
        if srcfile:
          logger.info('Found source: %s', srcfile)
          compilation_info = database.GetCompilationInfoForFile(srcfile)

    if len(compilation_info.compiler_flags_) == 0 and use_neighbor_file:
      for f in os.listdir(os.path.dirname(filename)):
        compilation_info = database.GetCompilationInfoForFile(os.path.abspath(os.path.dirname(filename) + os.path.sep + f))
        if len(compilation_info.compiler_flags_) != 0:
          break

  if compilation_info and len(compilation_info.compiler_flags_) != 0:
    final_flags = MakeRelativePathsInFlagsAbsolute(
        compilation_info.compiler_flags_,
        compilation_info.compiler_working_dir_ )
  else:
    logger.info('No compilation database found: using default instead')
    if relative_to_config:
      relative_to = DirectoryOfThisScript()
    else:
      relative_to = os.path.dirname(os.path.abspath(filename))

    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
    }
