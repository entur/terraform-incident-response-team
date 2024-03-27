variables {
  pagerduty_token = "test_dummy"
  team_manifest   = file("./tests/team.yaml")
}

mock_provider "pagerduty" {}

run "team_is_created" {
  command = plan

  assert {
    condition     = pagerduty_team.team.name == "awesome"
    error_message = format("Team name is incorrect. Expected %s but was %s", "awesome", pagerduty_team.team.name)
  }
}

run "team_schedule_is_created" {
  command = plan

  assert {
    condition     = pagerduty_schedule.schedule.name == "Awesome - On Call"
    error_message = format("Team schedule name is incorrect. Expected %s but was %s", "Awesome - On Call", pagerduty_schedule.schedule.name)
  }
}

run "team_escalation_policy_is_created" {
  command = plan

  assert {
    condition     = pagerduty_escalation_policy.team_policy.name == "Awesome"
    error_message = format("Team escalation policy name is incorrect. Expected %s but was %s", "Awesome", pagerduty_escalation_policy.team_policy.name)
  }
}

run "business_services_are_created" {
  command = plan

  assert {
    condition     = length(pagerduty_business_service.business_service) == 2
    error_message = format("The wrong amount of business services were created. Expected %s but was %s", 2, length(pagerduty_business_service.business_service))
  }
  assert {
    condition     = pagerduty_business_service.business_service["core"] != null
    error_message = "Business service \"core\" was not created"
  }
  assert {
    condition     = pagerduty_business_service.business_service["flow"] != null
    error_message = "Business service \"flow\" was not created"
  }
}

run "team_members_are_added" {
  command = plan

  assert {
    condition     = length(pagerduty_team_membership.team_members) == 6
    error_message = format("The wrong amount of team members were added. Expected %s but was %s", 6, length(pagerduty_team_membership.team_members))
  }
}

