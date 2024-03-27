output "name" {
  value = pagerduty_team.team.name
}

output "id" {
  value = pagerduty_team.team.id
}

output "escalation_policy_id" {
  value = pagerduty_escalation_policy.team_policy.id
}

output "business_services" {
  value = pagerduty_business_service.business_service
}
