# helm

#Usage
Helm must be installed to use the charts. Please refer to Helm’s documentation to get started.

Once Helm has been set up correctly, add the repo as follows:

helm repo add <name repo> https://<username>.github.io/HELM/
If you had already added this repo earlier, run helm repo update to retrieve the latest versions of the packages. You can then run helm search repo <alias> to see the charts.

To install the chart:

helm install <name release>
To uninstall chart:

helm delete <name release>