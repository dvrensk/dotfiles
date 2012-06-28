#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
# export HADOOP_INSTALL=~/Icehouse/hadoop/hadoop-0.20.1
# export HADOOP_HOME=$HADOOP_INSTALL
# export PIG_INSTALL=~/Icehouse/hadoop/pig-0.5.0
# export PATH=$PATH:$HOME/bin/elastic-mapreduce-ruby:$HADOOP_INSTALL/bin:$PIG_INSTALL/bin

# EC2
export EC2_HOME=$HOME/bin/ec2-api-tools
export PATH=$PATH:$EC2_HOME/bin
function load_ec2 {
  export AMAZON_ACCESS_KEY_ID=$(security -q find-generic-password -s "AWS Releware" | grep 'acct..blob' | cut -d'"' -f4)
  export AMAZON_SECRET_ACCESS_KEY=$(security -q find-generic-password -s "AWS Releware" -g 2>&1 1>/dev/null | cut -d'"' -f2)
  export EC2_URL=https://eu-west-1.ec2.amazonaws.com/
  export SDB_URL=https://sdb.eu-west-1.amazonaws.com/
  export EC2_CERT=$(echo $HOME/.ec2/cert-*.pem)
  export EC2_PRIVATE_KEY=$(echo $HOME/.ec2/pk-*.pem)
}
function unload_ec2 {
  export AMAZON_ACCESS_KEY_ID=
  export AMAZON_SECRET_ACCESS_KEY=
  export EC2_CERT=
  export EC2_PRIVATE_KEY=
}
