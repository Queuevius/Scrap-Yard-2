Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new('AKIAJ67BYEXT75QO56KQ', 'kBsuLvQB5qdzxLKemH7WkkkXluWULkBIgA/k3SLg'),
})

S3_BUCKET = Aws::S3::Resource.new.bucket("needpediasbucket")