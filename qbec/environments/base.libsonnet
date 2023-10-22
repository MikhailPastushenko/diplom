// this file has the baseline default parameters
{
  components: {
    testchessanalyzer: {
      "replicas": 3,
      "name": "testchessanalyzer",
      "image": "mikhailpastushenko/testchessanalyzer",
      "ports": {
         "containerPort": 80
      },
      "service": {
         "port": 9000
      }
    }
  }
}
