package main

import (
	"context"
	"fmt"
	"log"

	"github.com/connergorman/keel/client/register"
	v1 "github.com/connergorman/keel/gen/cluster/v1"
)

func main() {
	ctx := context.Background()
	client, err := register.NewRegisterClusterServiceClient(ctx)
	if err != nil {
		log.Fatal("oops")
	}
	var resp *v1.RegisterResponse
	resp, err = client.Register(ctx, &v1.RegisterRequest{Name: "test", Env: "dev", Region: "local"})
	if err != nil {
		log.Fatalf("Request to registration service failed: %v", err)
	}
	fmt.Printf("Response: %v", resp)
}
