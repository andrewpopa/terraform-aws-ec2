describe os.family do
  it { should eq 'debian' }
end

describe filesystem('/') do
  its('size_kb') { should be >= 50000 }
  its('type') { should cmp 'ext' }
end

describe aws_ec2_instance(name: 'my-ptfe-instance') do
  it { should be_running }
end

describe aws_ec2_instance(name: 'my-ptfe-instance') do
  its('image_id') { should eq 'ami-0085d4f8878cddc81' }
end