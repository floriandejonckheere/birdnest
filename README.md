# Birdnest

![Continuous Integration](https://github.com/floriandejonckheere/birdnest/workflows/Continuous%20Integration/badge.svg)
![Release](https://img.shields.io/github/v/release/floriandejonckheere/birdnest?label=Latest%20release)

Birdnest is a simple web application that lists drones in a No-Drone Zone (NDZ).
It was made for [Reaktor's internship](https://assignments.reaktor.com/birdnest/) assignment.

## Usage

Execute `bin/birdnest` to launch the web application.
It is available on [http://localhost:8080/](http://localhost:8080).

## Release

Update the changelog and bump the version using the `bin/version` tool.
Run `bin/version --help` to see all parameters.
Create a git tag for the version and push it to Github.
A Docker image will automatically be built and pushed to Github Container registry.

```sh
bin/version version 1.0.0
git add lib/birdnest/version.rb
git commit -m "Bump version to v1.0.0"
git tag v1.0.0
git push origin master
git push origin v1.0.0
```

## Contributing

1. Fork the repository (<https://github.com/floriandejonckheere/birdnest/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

See [LICENSE.md](LICENSE.md).
