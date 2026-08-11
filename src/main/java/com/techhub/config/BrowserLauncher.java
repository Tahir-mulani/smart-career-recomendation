package com.techhub.config;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class BrowserLauncher {

	@EventListener(ApplicationReadyEvent.class)
	public void openBrowser() {

		String url = "http://localhost:8080/";

		try {
			System.out.println("========================================");
			System.out.println("BrowserLauncher: Application is ready!");
			System.out.println("Opening browser: " + url);
			System.out.println("========================================");

			// Wait a little so Tomcat is completely ready
			Thread.sleep(1500);

			// Windows URL launcher
			new ProcessBuilder("cmd", "/c", "start", "", url).start();

		} catch (Exception e) {
			System.err.println("Could not open browser automatically.");
			e.printStackTrace();
		}
	}
}