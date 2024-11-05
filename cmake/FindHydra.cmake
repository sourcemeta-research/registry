if(NOT Hydra_FOUND)
  set(HYDRA_INSTALL OFF CACHE BOOL "disable installation")
  set(HYDRA_BUCKET OFF CACHE BOOL "disable S3 bucket support")
  add_subdirectory("${PROJECT_SOURCE_DIR}/vendor/hydra")
  set(Hydra_FOUND ON)
endif()
