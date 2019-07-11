Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new('XXXX', 'XXXX'),
})

S3_BUCKET = Aws::S3::Resource.new.bucket("XXXX")