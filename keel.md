# Keel

Keel is an idea to make initial cluster provisioning easier. The basic idea is this:

- when provisioning a cluster you apply a static manifest that deploys the keel client on cluster startup
- the keel client does self checks of the cluster to determine health etc
- the keel client has a cert to authenticate itself to the keel server (cert needs to be provided at cluster provisioning time)
- the keel client sends the healthcheck payload to
