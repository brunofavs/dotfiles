return
{

  settings = {
      python = {
        analysis = {
          typeCheckingMode = "standard",

          diagnosticSeverityOverrides = {
              -- strictListInference = "warning",
              -- strictDictionaryInference = "warning",
              -- strictSetInference = "warning",
              reportPossiblyUnboundVariable = "none"
          },

            extraPaths = {
              -- "/home/bruno/ros_ws/atom_ttc_ws/src/atom_annotation_ML/atom_core/src",
            }
        }
      }
  }
}
