(props to 'Pika Do' for pikado/alpine-svn)

# Test repo for svnmerkleizer-test-repo

Alpine Linux + Subversion via Apache2's interface on port 80 for WebDAV (on the container)

# Building it and running (no version on Dockerhub yet)

```
$ git clone git@github.com:paul-hammant-fork/svnmerkleizer-test-repo.git
$ cd svnmerkleizer-test-repo
$ docker build -t paul-hammant/svnmerkleizer-test-repo .
$ docker run -d -p 8098:80 -P paul-hammant/svnmerkleizer-test-repo
```

^ The container starts with the default account: davsvn (password: davsvn) and a repository at http://localhost:8098/svn/dataset/

# Using it

Instances are not intended to be used by humans. Test suites are though, including one at https://github.com/paul-hammant/svnmerkleizer