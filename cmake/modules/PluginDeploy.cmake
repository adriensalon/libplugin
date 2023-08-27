# @brief plugin_bundle internal function
# @param target 
# @param platform 
# @param company 
# @param backend 
function(plugin_bundle target platform company backend)
	if(platform STREQUAL "MacOS")
		smtg_target_set_bundle(${target}
			BUNDLE_IDENTIFIER com.${company}.${target}
			COMPANY_NAME "${company}")
	elseif(platform STREQUAL "Windows")
		target_sources(${target} PRIVATE ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../templates/win32resource.rc)
	endif()
endfunction()

# @brief plugin_validate internal function
# @param target 
# @param backend 
# @param enabled 
function(plugin_validate target backend enabled)
	if(enabled)
		if(backend STREQUAL "VST2")
			message("-- [libaudioplugin] Selecting VST2 validator tool")
			smtg_target_run_vst_validator(${target})
		elseif(backend STREQUAL "VST3")
			message("-- [libaudioplugin] Selecting VST3 default validator tool that comes with the SDK")
			smtg_target_run_vst_validator(${target})
		elseif(backend STREQUAL "AUV2" OR backend STREQUAL "AUV3")
			message("-- [libaudioplugin] Selecting ${target} validation with the auval command")
			add_custom_command(TARGET ${target} POST_BUILD
				COMMAND auval -v ${target})
		elseif(backend STREQUAL "AAX")
			message("-- [libaudioplugin] Selecting no AAX validation tool because the AAX host SDK is not public")
		else()
			message(FATAL_ERROR "[libaudioplugin] Invalid backend '${backend}'")
		endif()
	endif()
endfunction()

# @brief plugin_clean internal function
# @param target
# @param backend 
function(plugin_clean target backend)
	if(backend STREQUAL "AAX")		
		# add_custom_command(TARGET ${target} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${target}> ${LIBAUDIOPLUGIN_BUILD_PATH})
		# add_custom_command(TARGET ${target} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}/AAXPLUGIN)
	elseif(backend STREQUAL "AUV2")
		

	elseif(backend STREQUAL "AUV3")
		

	elseif(backend STREQUAL "VST2")
		# add_custom_command(TARGET ${plugin_name} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${plugin_name}> ${LIBAUDIOPLUGIN_BUILD_PATH})
		# add_custom_command(TARGET ${plugin_name} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}/VST3)
	elseif(backend STREQUAL "VST3")
		# # add_custom_command(TARGET ${target} PRE_BUILD
		# # 	COMMAND ${CMAKE_COMMAND} -E rm -R ${LIBAUDIOPLUGIN_BUILD_PATH})
		# add_custom_command(TARGET ${target} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${target}> ${LIBAUDIOPLUGIN_BUILD_PATH}_temp)
		# add_custom_command(TARGET ${target} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E remove_directory ${LIBAUDIOPLUGIN_BUILD_PATH})
		# add_custom_command(TARGET ${target} POST_BUILD
		# 	COMMAND ${CMAKE_COMMAND} -E rename ${LIBAUDIOPLUGIN_BUILD_PATH}_temp ${LIBAUDIOPLUGIN_BUILD_PATH})
	else()
		message(FATAL_ERROR "[libaudioplugin] Invalid backend")
	endif()	

endfunction()
