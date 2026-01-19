// Package register handles registration services
package register

import (
	"context"
	"net/http"

	"github.com/connergorman/keel/gen/cluster/v1/clusterv1connect"
)

func NewRegisterClusterServiceClient(ctx context.Context) (clusterv1connect.RegisterClusterServiceClient, error) {
	hc := &http.Client{}
	url := "http://localhost:8080"
	return clusterv1connect.NewRegisterClusterServiceClient(hc, url), nil
}
