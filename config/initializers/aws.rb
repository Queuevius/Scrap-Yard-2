Aws.config.update({
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_KEY']),
})
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUK'])

# Aws.config.update({
#   region: "test",
#   credentials: Aws::Credentials.new("test", "test"),
# })
# S3_BUCKET = Aws::S3::Resource.new.bucket("test")