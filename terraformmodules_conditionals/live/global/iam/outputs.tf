/*
output "neo_arn" {
  value       = aws_iam_user.examplecv
  description = "The ARN for user cvdon"
}
*/
output "all_arns" {
  value       = aws_iam_user.example[*].arn
  description = "The ARNs for all users"
}

output "all_users" {
  value = aws_iam_user.example
}
/*
output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}*/

output "upper_names" {
  value = [for name in var.names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = <<EOF
  %{for name in var.names}
    ${name}
  %{endfor}
  EOF
}

output "for_directive_strip_marker" {
  value = <<EOF
  %{~for name in var.names~}
    ${name}
  %{~endfor~}
  EOF
}

output "if_else_directive" {
  value = "Hello, %{if var.name != ""}${var.name}%{else}(unnamed)%{endif}"
}
