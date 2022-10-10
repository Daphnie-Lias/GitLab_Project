/* Create S3 access role with inline policy */

resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"
  path = "/"

  assume_role_policy = "${file("./modules/s3//assumerolepolicy.json")}"
}

/* Create Iam instance profile */

resource "aws_iam_instance_profile" "test_profile" {
  name = "terraform_instance_profile"
  path = "/"

  role = "${aws_iam_role.s3_access_role.name}"
}

/* Create AWS Iam policy and attach policy to S3 ccess role */

resource "aws_iam_policy" "s3_code_bucket_access_policy" {
  name        = "s3_code_bucket_access_policy"

  policy      = "${file("./modules/s3/policys3bucket.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.s3_code_bucket_access_policy.arn}"
}
