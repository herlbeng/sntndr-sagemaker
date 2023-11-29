resource "aws_s3_bucket" "training_data" {
    bucket = var.s3_bucket_input_training_path
}

resource "aws_s3_bucket_ownership_controls" "training_rule" {
    bucket = aws_s3_bucket.training_data.id
    rule {
      object_ownership = "ObjectWriter"
    } 
}

resource "aws_s3_bucket_acl" "training_data_acl" {
    bucket = aws_s3_bucket.training_data.id
    acl =  "private"
    depends_on = [ aws_s3_bucket_ownership_controls.training_rule ]
}

resource "aws_s3_bucket_object" "object" {
    bucket = aws_s3_bucket.training_data.id
    key = "iris.csv"
    source = var.s3_object_training_data
}

resource "aws_s3_bucket" "output_models" {
    bucket = var.s3_bucket_output_models_path
}

resource "aws_s3_bucket_ownership_controls" "output_rule" {
    bucket = aws_s3_bucket.output_models.id
    rule {
        object_ownership = "ObjectWriter"
    }
}

resource "aws_s3_bucket_acl" "output_models_acl" {
    bucket = aws_s3_bucket.output_models.id
    acl = "private"
    depends_on = [ aws_s3_bucket_ownership_controls.output_rule ]
}


