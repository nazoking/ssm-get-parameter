package main

import (
	"flag"
	"fmt"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ssm"
)

func main() {
	sess := session.Must(session.NewSession())
	svc := ssm.New(sess)
	flag.Parse()
	args := flag.Args()

	for _, path := range args {
		enc := true
		inp := &ssm.GetParameterInput{
			Name:           &path,
			WithDecryption: &enc,
		}
		out, err := svc.GetParameter(inp)
		if err != nil {
			panic(fmt.Errorf("error in get %s: %v", path, err))
		}
		fmt.Println(*out.Parameter.Value)
	}
}
