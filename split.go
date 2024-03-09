package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os/exec"
)

type Msg struct {
	Change    string    `json:"change"`
	Container Container `json:"container"`
}

type Container struct {
	WindowRect Rect `json:"window_rect"`
}

type Rect struct {
	Width  int `json:"width"`
	Height int `json:"height"`
}

func main() {
	msgEvent := exec.Command("i3-msg", "-t", "subscribe", "-m", "[ \"window\" ]")
	stdout, _ := msgEvent.StdoutPipe()
	msgEvent.Start()
	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		m := scanner.Text()
		var msg Msg
		json.Unmarshal([]byte(m), &msg)
		if msg.Change == "focus" {
			if msg.Container.WindowRect.Width > msg.Container.WindowRect.Height {
				fmt.Println("Next split will be horizontal")
				exec.Command("i3-msg", "split", "horizontal").Run()
			} else {
				fmt.Println("Next split will be vertical")
				exec.Command("i3-msg", "split", "vertical").Run()
			}
		}
	}
	msgEvent.Wait()
}
