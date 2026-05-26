data "aws_iam_policy_document" "myapp_secrets" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test = "StringEquals"

      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:fastapi:fastapi"
      ]
    }
  }
}

resource "aws_iam_role" "myapp_secrets" {
  name = "${var.cluster_name}-myapp-secrets"
  assume_role_policy = data.aws_iam_policy_document.myapp_secrets.json
}

resource "aws_iam_policy" "myapp_secrets" {
  name = "${var.cluster_name}-myapp-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*" # ideally restrict to specific secret ARN
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "myapp_secrets" {
  role = aws_iam_role.myapp_secrets.name
  policy_arn = aws_iam_policy.myapp_secrets.arn
}