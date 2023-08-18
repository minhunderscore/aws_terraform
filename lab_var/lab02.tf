locals {
  lab02 = {
    ##########################
    # S3 CONFIG
    ##########################
    s3 = {
      pipeline_artifact = {
        module_name = "pipeline-artifact"
      }
      s3_storage = {
        module_name = "s3-storage"
      }
    }

  }
}
