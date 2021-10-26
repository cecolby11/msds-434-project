# used by the offcycle jenkins job

output "project_id" {
  value = module.dev.project_id
}

output "project_region" {
  value = module.dev.project_region
}

output "project_zone" {
  value = module.dev.project_zone
}

output "app_engine_id" {
  value = module.dev.app_engine_id
}

output "app_engine_app_id" {
  value = module.dev.app_engine_app_id
}
