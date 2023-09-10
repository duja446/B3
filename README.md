<a name="readme-top"></a>

[![GitHub Repo stars][stars-shield]][stars-url]
[![MIT License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/duja446/B3">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Bluetooth Amp</h3>

  <p align="center">
    A self hosted webapp that plays music through bluetooth.
    <br />
    <a href="https://github.com/duja446/B3"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/duja446/B3">View Demo</a>
    ·
    <a href="https://github.com/duja446/B3/issues">Report Bug</a>
    ·
    <a href="https://github.com/duja446/B3/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is a simple application that stores uploaded images and serves them. I made it for use in my self hosted Phoenix applications because Phoenix requires dynamic images to be available on an external service like S3 buckets. 

This application only handles images. Also you can specify the quality of the image you want to save which are then modified by Mogrify.
<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Elixir][Elixir]][Elixir-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

Here is an example of how you can configure an run the project

### Prerequisites

* Install and configure ImageMagick ([Arch wiki](https://wiki.archlinux.org/title/ImageMagick))

### Installation

1. Clone the repo
    ```sh
    git clone https://github.com/duja446/B3
    ```
2. Install the dependancies 
    ```sh
    mix deps.get
    ```
4. Run the project
    ```sh
    mix run
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

After running the application you can access it on `localhost:4001` for developement and `localhost:80` for production.

Three endpoint are available:
    1. `GET /files/:file_name` - serves the file
    2. `POST /upload` - name, file, and quality (0% - 100%) need to be specified - upload the file
    3. `GET /list` - lists the files available

### Elixir usage example

Here is an example of how you can implement this into a Phoenix application

```elixir
defmodule SampleApplication.B3 do

  def upload(name, file_path, quality \\ 100) do
    HTTPoison.post!(
      "localhost:4001/upload", 
      {:multipart, [
        {"name", name},
        {"quality", Integer.to_string(quality)},
        {:file, file_path}
      ]}
    )
  end

  def get_url(name) do
    "http://localhost:4001/files/#{name}"
  end

  
end
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Implement cache
- [ ] Multi user support

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Dusan Veljkovic - duja446@gmail.com

Project Link: [https://github.com/duja446/B3](https://github.com/duja446/B3)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[stars-shield]: https://img.shields.io/github/stars/duja446/B3.svg?style=for-the-badge
[stars-url]: https://github.com/duja446/duja446/stargazers
[license-shield]: https://img.shields.io/github/license/duja446/B3.svg?style=for-the-badge
[license-url]: https://github.com/duja446/B3/blob/master/LICENSE.txt

[Elixir]: https://img.shields.io/badge/elixir-%234B275F.svg?style=for-the-badge&logo=elixir&logoColor=white
[Elixir-url]: https://elixir-lang.org/
