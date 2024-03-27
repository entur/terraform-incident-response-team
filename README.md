# Terraform module for setting up teams for incident response

This module is used for creating and updating teams in the current incident response solution
PagerDuty. Teams set up through this solution will have a schedule and escalation policy
that notifies the team within ordinary work hours and the standby developer or the on-call 
incident manager outside of it.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_business_service.business_service](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/business_service) | resource |
| [pagerduty_escalation_policy.team_policy](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/escalation_policy) | resource |
| [pagerduty_schedule.schedule](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/schedule) | resource |
| [pagerduty_slack_connection.slack_connection](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/slack_connection) | resource |
| [pagerduty_team.team](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/team) | resource |
| [pagerduty_team_membership.team_members](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/resources/team_membership) | resource |
| [pagerduty_user.members](https://registry.terraform.io/providers/pagerduty/pagerduty/3.6.0/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | Pagerduty API token | `string` | n/a | yes |
| <a name="input_team_manifest"></a> [team\_manifest](#input\_team\_manifest) | The specification yaml of the team | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_business_services"></a> [business\_services](#output\_business\_services) | n/a |
| <a name="output_escalation_policy_id"></a> [escalation\_policy\_id](#output\_escalation\_policy\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->