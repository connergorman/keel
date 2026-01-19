package main

import (
	"net/http"

	"github.com/connergorman/keel/gen/cluster/v1/clusterv1connect"
	"github.com/connergorman/keel/server/register"
)

func main() {
	registrar := &register.RegisterServer{}
	mux := http.NewServeMux()
	path, handler := clusterv1connect.NewRegisterClusterServiceHandler(
		registrar,
	)
	mux.Handle(path, handler)
	p := new(http.Protocols)
	p.SetHTTP1(true)
	// Use h2c so we can serve HTTP/2 without TLS.
	p.SetUnencryptedHTTP2(true)
	s := http.Server{
		Addr:      "localhost:8080",
		Handler:   mux,
		Protocols: p,
	}
	s.ListenAndServe()
}
