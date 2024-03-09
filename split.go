package main

import (
	"bufio"
	"encoding/json"
	"log"
	"os"
	"os/exec"
	"slices"
)

type Msg struct {
	Change    string    `json:"change"`
	Container Container `json:"container"`
}

type Container struct {
	WindowRect WindowRect `json:"window_rect"`
}

type WindowRect struct {
	Width  int `json:"width"`
	Height int `json:"height"`
}

func main() {
	debug := slices.Contains(os.Args, "--debug")
	msgEvent := exec.Command("i3-msg", "-t", "subscribe", "-m", "[ \"window\" ]")

	stdout, err := msgEvent.StdoutPipe()
	if err != nil {
		log.Fatal(err)
		return
	}

	msgEvent.Start()
	scanner := bufio.NewScanner(stdout)

	for scanner.Scan() {
		var msg Msg

		m := scanner.Text()
		err := json.Unmarshal([]byte(m), &msg)
		if err != nil {
			log.Fatal(err)
			return
		}

		if msg.Change == "focus" {
			if msg.Container.WindowRect.Width > msg.Container.WindowRect.Height {
				if debug {
					println("Width", msg.Container.WindowRect.Width, ", Height", msg.Container.WindowRect.Height, " ,Next split will be horizontal")
				}
				exec.Command("i3-msg", "split", "horizontal").Run()
			} else {
				if debug {
					println("Width", msg.Container.WindowRect.Width, ", Height", msg.Container.WindowRect.Height, " ,Next split will be vertical")
				}
				exec.Command("i3-msg", "split", "vertical").Run()
			}
		}
	}

	msgEvent.Wait()
}
