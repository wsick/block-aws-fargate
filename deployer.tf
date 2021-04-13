resource "aws_iam_user" "deployer" {
  name = "deployer-${random_string.resource_suffix.result}"
  tags = data.ns_workspace.this.tags
}

resource "aws_iam_access_key" "deployer" {
  user = aws_iam_user.deployer.name
}

// The actions listed are necessary to perform actions to deploy ECS service
resource "aws_iam_user_policy" "deployer" {
  name   = "AllowECSDeploy"
  user   = aws_iam_user.deployer.name
  policy = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    sid    = "AllowEditTaskDefinitions"
    effect = "Allow"

    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:DeregisterTaskDefinition",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowClusterUpdates"
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "ecs:cluster"
      values   = [aws_ecs_cluster.this.arn]
    }
  }
}