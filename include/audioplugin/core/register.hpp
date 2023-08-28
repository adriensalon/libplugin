#pragma once

#include <audioplugin/glue/factory.hpp>

/// @brief
#if !defined(AUDIOPLUGIN_PROCESSOR_UID)
#define AUDIOPLUGIN_PROCESSOR_UID libaudioplugin::detail::processor_uid
#endif

/// @brief
#if !defined(AUDIOPLUGIN_CONTROLLER_UID)
#define AUDIOPLUGIN_CONTROLLER_UID libaudioplugin::detail::controller_uid
#endif

/// @brief
#define REGISTER_PLUGIN(processor_class_m, controller_class_m)              \
    AUDIOPLUGIN_VERIFY_PLUGIN(processor_class_m, controller_class_m)          \
    AUDIOPLUGIN_ADD_PLUGIN(processor_class_m, controller_class_m)             \
    AUDIOPLUGIN_ADD_PLUGIN_AAX_WRAPPER()                                      \
    AUDIOPLUGIN_ADD_PLUGIN_AU2_WRAPPER(processor_class_m, controller_class_m) \
    AUDIOPLUGIN_ADD_PLUGIN_AU3_WRAPPER(processor_class_m, controller_class_m) \
    AUDIOPLUGIN_ADD_PLUGIN_VST2_WRAPPER()

#if defined(LIBAUDIOPLUGIN_BUILD_AAX_WRAPPER)

/// @brief
#define AAX_ADDITIONAL_OUTPUT(output_name_m, channels_count_m) \
    AAX_Aux_Desc { output_name_m, channels_count_m }

/// @brief
#define AAX_ADDITIONAL_OUTPUTS_ARRAY(...) \
    AAX_Aux_Desc effAux_stereo[] = { __VA_ARGS__, { nullptr } };

/// @brief
#define AAX_MIDI_INPUT(port_name_m, channel_mask_m) \
    AAX_MIDI_Desc { port_name_m, channel_mask_m }

/// @brief
#define AAX_MIDI_INPUTS_ARRAY(...) \
    AAX_MIDI_Desc effMIDI[] = { __VA_ARGS__, { nullptr } };

/// @brief
#define AAX_METER(meter_name_m, parameter_id_m, is_output_m) \
    AAX_Meter_Desc { meter_name_m, parameter_id_m, 0, is_output_m }

/// @brief
#define AAX_METERS_ARRAY(...) \
    AAX_Meter_Desc effMeters[] = { __VA_ARGS__, { nullptr } };

/// @brief
#define AAX_VARIANT(variant_name_m, input_channels_m, output_channels_m, sidechain_input_channels_m, latency_m) \
    AAX_Plugin_Desc                                                                                              \
    {                                                                                                            \
        "com." PLUGIN_COMPANY "." PLUGIN_NAME "." variant_name_m,                                                \
            PLUGIN_NAME,                                                                                         \
            CCONST(variant_name_m[0], variant_name_m[1], variant_name_m[2], 'A'),                                \
            CCONST(variant_name_m[0], variant_name_m[1], variant_name_m[2], 'B'),                                \
            input_channels_m,                                                                                    \
            output_channels_m,                                                                                   \
            sidechain_input_channels_m,                                                                          \
            latency_m                                                                                            \
    }

/// @brief
#define AAX_VARIANTS_ARRAY(...) \
    AAX_Plugin_Desc effPlugins[] = { __VA_ARGS__, { nullptr } };

#endif