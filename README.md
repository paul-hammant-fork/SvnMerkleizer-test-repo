(props to 'Pika Do' for pikado/alpine-svn)

# Test repo for svnmerkleizer-test-repo

Alpine Linux + Subversion via Apache2's interface on port 80 for WebDAV (on the guest container)

# Building it and running (no version on Dockerhub yet)

```
$ git clone git@github.com:paul-hammant-fork/svnmerkleizer-test-repo.git
$ cd svnmerkleizer-test-repo
$ docker build -t paul-hammant/svnmerkleizer-test-repo .
$ docker run -d -p 8098:80 -P paul-hammant/svnmerkleizer-test-repo
```

The container starts with a repository mounted at http://localhost:8098/svn/dataset/ on the host. You could do a regular Subversion checkout from there (or any subdirectory).

# Using it

Instances are not intended to be used by humans. Test suites are though, including one at https://github.com/paul-hammant/svnmerkleizer

# Notes

See [authz.authz](authz.authz) for the two users within the repo: `harry` and `sally`. Harry's password is `harrypw`, and sally's password is `sallypw`. Thet have different permissions to the director tree. One can essentially see more directories than the others.
