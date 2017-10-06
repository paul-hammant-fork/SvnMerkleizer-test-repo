# alpine-svn (Docker Image)

Alpine Linux + Subversion via Apache2's interface on port 80 for WebDAV (on the container)

## Image special features:

1. SVNAutoversioning turned on, to allow PUTs from non-Subversion clients to work (with default commit message)
2. DepthInfinity is also turned on, to allow deep querying for changed files, which probably means you should NOT allow anon access.

## Versions of key components

* Alipine Linux is presently v3.6
* Subversion is presently v1.9.7
* Apache is presently v2.4.27

# Building it (it is not up on Dockerhub)

```
$ git clone git@github.com:paul-hammant/alpine-svn.git
$ cd alpine-svn
$ docker build -t paul-hammant/alpine-svn .
```

# Running it

Starting container with docker command:

```
$ docker run -d -P paul-hammant/alpine-svn
```
^ The container starts with the default account: davsvn (password: davsvn) and the default repository: testrepo

## Alternates

```
$ docker run -d -e SVN_REPO=repo -P paul-hammant/alpine-svn
```
^ The container starts with the default account: davsvn (password: davsvn) and the specified repository: repo

```
$ docker run -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass -P paul-hammant/alpine-svn
```
^ The container starts with the specified account: user (password: pass) and the default repository: testrepo

```
$ docker run -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass -e SVN_REPO=repo -P paul-hammant/alpine-svn
```
^ The container starts with the specified account: user (password: pass) and the specified repository: repo

## Host storage

Docker allocates an expanding sorage file to the container. The default for that is 50GB.

# Using it

You need to take a note of the server address (it could have been overridden with a `-p hostPort:guestPort` option on the run command, but was not.
```
$ docker ps 
CONTAINER ID        IMAGE                     COMMAND             CREATED             STATUS              PORTS                   NAMES
2f43a74191c0        paul-hammant/alpine-svn   "/run.sh"           5 seconds ago       Up 3 seconds        0.0.0.0:32768->80/tcp   clever_murdock
```

Then, in a new directory elsewhere:

```
svn co --username davsvn --password davsvn http://0.0.0.0:32768/svn/testrepo
cd testrepo
# the add/chg/commit, as usual
```
32768 was what you picked out of `docker ps`.

And in fresh directory somehere (not the git-checkout of alpine-svn), the magic:

```
echo "hello" > .greeting
curl -u davsvn:davsvn -X PUT -T .greeting http://0.0.0.0:32772/svn/testrepo/greeting.txt
```

Whereupon you can `svn up` back in the checkout to see it.

# Editorial: MOD_DAV_SVN Commit messages suck!

    `Autoversioning commit:  a non-deltaV client made a change to`

It would be nice if MOD_DAV_SVN could accept a header for a custom message. Source for that log message [is here](https://svn.apache.org/repos/asf/subversion/trunk/subversion/mod_dav_svn/version.c). There is also a
ticket for that change [SVN-4454](https://issues.apache.org/jira/browse/SVN-4454), that is presently
marked as 'Won't Fix'.

Refer http://svnbook.red-bean.com/en/1.7/svn.webdav.autoversioning.html for canonical SVNAutoversioning info.
