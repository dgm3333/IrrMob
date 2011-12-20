function(config_target targetname is_library)   
  if (IOS)
	set_target_properties(${targetname} PROPERTIES XCODE_ATTRIBUTE_GCC_UNROLL_LOOPS "YES")
	set_target_properties(${targetname} PROPERTIES XCODE_ATTRIBUTE_GCC_THUMB_SUPPORT "NO")
	set_target_properties(${targetname} PROPERTIES XCODE_ATTRIBUTE_GCC_PRECOMPILE_PREFIX_HEADER "YES")
	
	if (is_library)
	  set_target_properties(${targetname} PROPERTIES ARCHIVE_OUTPUT_DIRECTORY "bin$(EFFECTIVE_PLATFORM_NAME)")
	else()
	  set_target_properties(${targetname} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "bin$(EFFECTIVE_PLATFORM_NAME)")

	endif()
    set_target_properties(${targetname} PROPERTIES XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ${IOS_CODE_SIGN_ID})
  endif()
endfunction()

# executable target
function(irrmob_add_executable target sources resources)
  message("**** Executable:" ${target})
  if(APPLE)
    set(EXETYPE MACOSX_BUNDLE)
    set_source_files_properties(${${resources}} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    source_group(Resources FILES ${${resources}})
    add_executable(${target} ${EXETYPE} ${${sources}} ${${resources}})
  else()
    if(WIN32)
      set(EXETYPE WIN32)
    endif()
    add_executable(${target} ${EXETYPE} ${${sources}})
  endif()
  config_target(${target} FALSE)
endfunction()

# library target
function(irrmob_add_library target type sources)
  message("**** Library:" ${target} "    Type:" ${type})
  add_library(${target} ${type} ${${sources}})
  config_target(${target} TRUE)
endfunction()
