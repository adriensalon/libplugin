
#------------------------------------------------------------------------
function(setupAaxSupport)
    # AAX SDK Location
    if(SMTG_MAC OR SMTG_WIN)
        if("${SMTG_AAX_SDK_PATH}" STREQUAL "")
            # Check if the AAX SDK is next to the vst3sdk folder:
            set(AAX_SDK_PATH ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../../external.avid.aax)
            if(NOT EXISTS "${AAX_SDK_PATH}/Interfaces/AAX.h")
                # Check if the AAX SDK is in the vst3sdk folder:
                set(AAX_SDK_PATH ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../external.avid.aax)
                if(NOT EXISTS "${AAX_SDK_PATH}/Interfaces/AAX.h")
                    set(AAX_SDK_PATH "")
                endif()
            endif()
            if(NOT "${AAX_SDK_PATH}" STREQUAL "")
                get_filename_component(AAX_SDK_PATH "${AAX_SDK_PATH}" ABSOLUTE)
            endif()
            set(SMTG_AAX_SDK_PATH "${AAX_SDK_PATH}" CACHE PATH "Here you can define where to find the AAX SDK" FORCE)
        else()
            set(AAX_SDK_PATH "${SMTG_AAX_SDK_PATH}")
            if(NOT IS_ABSOLUTE ${AAX_SDK_PATH})
                get_filename_component(AAX_SDK_PATH "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../../${AAX_SDK_PATH}" ABSOLUTE)
            endif()
            if(NOT EXISTS "${AAX_SDK_PATH}/Interfaces/AAX.h")
                message(FATAL_ERROR "[SMTG] SMTG_AAX_SDK_PATH is set but does not point to an expected location!")
            else()
                set(SMTG_AAX_SDK_PATH "${AAX_SDK_PATH}" CACHE PATH "Here you can define where to find the AAX SDK" FORCE)
            endif()
        endif()
        if(EXISTS "${SMTG_AAX_SDK_PATH}")
            message(STATUS "[SMTG] SMTG_AAX_SDK_PATH is set to: " ${SMTG_AAX_SDK_PATH})
        else()
            message(STATUS "[SMTG] SMTG_AAX_SDK_PATH is not set. If you need it, please download the AAX SDK!")
        endif()
    endif(SMTG_MAC OR SMTG_WIN)
endfunction(setupAaxSupport)
