data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "action" {
  name               = "${local.prefix}-action-role"
  assume_role_policy = data.aws_iam_policy_document.action_assume_role_policy.json
}

data "aws_iam_policy_document" "action_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:koki-develop/checkip:*"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "action" {
  role       = aws_iam_role.action.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
