terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

provider "local" {
  # Configuration options
}


terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "!=2.3.0"  ## ----> it will not download that version
    }
  }
}

terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "< 2.3.0" ## -----> version should be less that this
    }
  }
}

terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = ">1.2.0,< 2.3.0, !2.1.0" ## -----> version should be less that this    }
    }
  }
}
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~>1.2"
      ## -----> this can download version 1.2,1.3,1.9 but not 1.3
      version = "~>1.3.0" #
      ## this can download upto 1.3.9 but not 1.4
    }
  }
}
