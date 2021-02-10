# Sorry Cypress Helm Chart

> :warning: **Please note**: This helm charts might still have a lot of unsupported custom configuration yet. Additionally it's only tested to work on nginx ingress so it's not properly tested yet to run on haproxy ingress or even AWS ELB

This repository contains self-writtern helm chart to run sorry-cypress dashboard on Kubernetes.

For full documentation on how to use sorry-cypress, please refer to their github page
[sorry-cypress](https://github.com/sorry-cypress/sorry-cypress).

## Prerequisites

To use the charts here, [Helm](https://helm.sh/) must be configured for your
Kubernetes cluster. Setting up Kubernetes and Helm and is outside the scope of
this README. Please refer to the Kubernetes and Helm documentation.

The versions required are:

  * **Helm 3.0+** - This is the earliest version of Helm tested. It is possible
    it works with earlier versions but this chart is untested for those versions.
  * **Kubernetes 1.8+** - This is the earliest version of Kubernetes tested.
    It is possible that this chart works with earlier versions but it is
    untested.
  * **AWS account** - You have to create IAM account with s3 permissions as part of the sorry-cypress director requirements. So ensure the IAM access key/secret key are created first followed by the s3 bucket as well

## Usage

To install the latest version of this chart, add the helm repository
and run `helm install`. Sample for `override.yaml` file provided in this repo:

```console
$ helm repo add reflex-cypress https://reflex-media.github.io/sorry-cypress-helm/
"reflex-cypress" has been added to your repositories

$ helm -n myapp install -f override.yaml myapp-cypress reflex-cypress/sorry-cypress
```
Or you can pass additional arguments to create the namespace in case if the namespace is not present yet `--create-namespace`

Please see the many options supported in the `values.yaml` file.

## Re-packaging notes

You can use the following commands to repackage the helm templates or if there are additional charts to be added
```console
$ helm package . -d docs/
$ helm repo index --url https://reflex-media.github.io/sorry-cypress-helm/ docs
```
