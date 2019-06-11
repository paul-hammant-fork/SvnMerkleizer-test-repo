# Test repo for SvnMerkleizer

Alpine Linux + Subversion via Apache2's MOD_DAV_SVN interface on port 80 (on the guest container).

Note there's an Alpine [bug](https://bugs.alpinelinux.org/issues/10116) at the moment that prevents Alpine from being upgraded past v3.7

# Building it and running (no version on Dockerhub yet)

```
$ git clone git@github.com:paul-hammant-fork/SvnMerkleizer-test-repo.git
$ cd SvnMerkleizer-test-repo
$ docker build -t paul-hammant/svnmerkleizer-test-repo .
$ docker run -d -p 8098:80 -P paul-hammant/svnmerkleizer-test-repo
```

The container starts with a repository mounted at http://localhost:8098/svn/dataset/ on the host. You could do a regular Subversion checkout from there (or any subdirectory).

# Using it

Instances are not intended to be used by humans. Test suites are though, including one at https://github.com/paul-hammant/SvnMerkleizer.

However to prove that the thing is working or not, do this curl command:

```
curl -u harry:harrypw http://localhost:8098/svn/dataset/
```

# Notes

1. There are two commits in this repo. The first is some county level voting info from a prior US election (the `dataset` directory). The second is the addition of a single file (the `secondCommit` directory).

2. See [authz.authz](authz.authz) for the two users within the repo: `harry` and `sally`. Harry's password is `harrypw`, and sally's password is `sallypw`. Thet have different permissions to the director tree. One can essentially see more directories than the others.

3. You should not use this Docker image for any production workload - it is for testing only and has known and shared passwords for users.

# Credits

Props to 'Pika Do' for pikado/alpine-svn.