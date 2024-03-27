locals {
  team_spec = yamldecode(var.team_manifest)
  # create a map from the list of members and their roles from the team spec
  team_members      = { for member in local.team_spec.members : member.mail => member }
  business_services = { for service in local.team_spec.business-services : service.name => service }
}

data "pagerduty_user" "members" {
  for_each = local.team_members
  email    = each.value.mail
}

resource "pagerduty_team" "team" {
  name        = local.team_spec.name
  description = local.team_spec.description
}

resource "pagerduty_team_membership" "team_members" {
  for_each = data.pagerduty_user.members
  user_id  = each.value.id
  team_id  = pagerduty_team.team.id
  role     = local.team_members[each.key].role
}

resource "pagerduty_schedule" "schedule" {
  name        = format("%s - On Call", title(pagerduty_team.team.name))
  description = format("On call schedule for team %s", title(pagerduty_team.team.name))
  time_zone   = "Europe/Copenhagen"
  layer {
    start                        = "2024-01-01T06:00:00+01:00"
    rotation_virtual_start       = "2024-01-01T06:00:00+01:00"
    rotation_turn_length_seconds = 604800
    users                        = values(data.pagerduty_user.members)[*].id
    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 28800
      start_day_of_week = 1
    }
    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 28800
      start_day_of_week = 2
    }
    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 28800
      start_day_of_week = 3
    }
    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 28800
      start_day_of_week = 4
    }
    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 28800
      start_day_of_week = 5
    }
  }
}

resource "pagerduty_escalation_policy" "team_policy" {
  name        = title(pagerduty_team.team.name)
  description = format("Policy for team %s for uttesting av provisjonering av PagerDuty", title(pagerduty_team.team.name))
  teams       = [pagerduty_team.team.id]
  num_loops   = 2
  rule {
    escalation_delay_in_minutes = 5
    target {
      id   = pagerduty_schedule.schedule.id
      type = "schedule_reference"
    }
  }
}

resource "pagerduty_slack_connection" "slack_connection" {
  source_id         = pagerduty_team.team.id
  source_type       = "team_reference"
  workspace_id      = "T2FQV6RJ8"
  channel_id        = "C06G9CSJ2MV"
  notification_type = "responder"
  config {
    events = [
      "incident.triggered",
      "incident.acknowledged",
      "incident.escalated",
      "incident.resolved",
      "incident.reassigned",
      "incident.annotated",
      "incident.unacknowledged",
      "incident.delegated",
      "incident.priority_updated",
      "incident.responder.added",
      "incident.responder.replied",
      "incident.status_update_published",
      "incident.reopened"
    ]
  }
}

resource "pagerduty_business_service" "business_service" {
  for_each         = local.business_services
  name             = each.key
  description      = each.value.description
  point_of_contact = title(format("Team %s", pagerduty_team.team.name))
  team             = pagerduty_team.team.id
}
