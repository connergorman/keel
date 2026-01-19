// Package register is the server handler for registerclusterservice
package register

import (
	"context"
	"fmt"

	v1 "github.com/connergorman/keel/gen/cluster/v1"
	"github.com/connergorman/keel/gen/cluster/v1/clusterv1connect"
)

type RegisterServer struct {
	clusterv1connect.UnimplementedRegisterClusterServiceHandler
}

func (s *RegisterServer) Register(ctx context.Context, request *v1.RegisterRequest) (*v1.RegisterResponse, error) {
	ret := &v1.RegisterResponse{
		RegistrationId: fmt.Sprintf("%s-%s-%s", request.Name, request.Env, request.Region),
	}
	return ret, nil
}
