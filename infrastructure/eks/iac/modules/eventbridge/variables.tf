variable "event_rule_name" {
    type = string
    description = "The name of the event."
    default = "k8s-and-heartbreak-example-event"
}

variable "event_pattern_name" {
    type = "string"
    description = "An event pattern name used to pull a JSON file."
    default = "events/detail-type/console_sign_in"
}

variable "event_target_arn" {
    type = "string"
    description = "The Amazon Resource Number (ARN) of the event target."
}


variable "event_rule_description" {
    type = string
    description = "What does this event rule do?"
    default = "k8s-and-heartbreak"
}
