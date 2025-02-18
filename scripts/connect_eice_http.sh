PEM_KEY_PATH = C:\Users\ayaki\key\kp.pem
LINUX_USER = ec2-user
ssh -i $PEM_KEY_PATH $LINUX_USER@localhost -p 2222 -L 5000:localhost:5000