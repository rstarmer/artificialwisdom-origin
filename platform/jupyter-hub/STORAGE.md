# Storage in Jupyter Hub

Storage is attached as a per-user PVC/PV claim in the underlying K8s.

It is possible to add a shared volume across resources in Hub (e.g. to provide access to a set of foundational models, or to share resources.).  That PVC/PV pair needs to be set up in advance of deploying a user's environment.

Add the following, pointing to the pre-created PVC to the deployment

```yaml
singleuser:
  storage:
    extraVolumes:
      - name: jupyterhub-shared
        persistentVolumeClaim:
          claimName: jupyterhub-shared-volume
    extraVolumeMounts:
      - name: jupyterhub-shared
        mountPath: /home/shared
```

In fact, we likely want to create a cron job to cache/refresh foundational models into that PVC so that users always have the latest claims available.