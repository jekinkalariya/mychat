package com.mychat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket/{clientId}")
public class WebSocketTest {

	private String clientId = "";
	static List<String> clientIds = new ArrayList<String>();

	static {
		clientIds.add("Jekin");
		clientIds.add("Rakshit");
		clientIds.add("Love");
		clientIds.add("Sandip");
		clientIds.add("10.210.22.77");
		clientIds.add("10.210.22.107");
		clientIds.add("10.210.24.22");
		clientIds.add("10.210.24.55");
		clientIds.add("10.210.0.63");
		
		
		

	}

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	private static Map<String, Session> clientsMap = Collections.synchronizedMap(new HashMap<String, Session>());
	private static Map<String, Integer> countMap = Collections.synchronizedMap(new HashMap<String, Integer>());
	private static List<String> activeClients = Collections.synchronizedList(new ArrayList<String>());

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {

		synchronized (clients) {
			// Iterate over the connected sessions
			// and broadcast the received message

			for (Session client : clients) {
				System.out.println("message receive" + message + "  clientId" + clientId);
				if (message.equals("clear")) {
					client.getBasicRemote().sendText("cleartypinguser");
				} else if (!client.equals(session) && message.contains("typinguser")) {
					client.getBasicRemote().sendText("typinguser" + clientId);
				} else if (!client.equals(session)) {

					client.getBasicRemote().sendText(message + "thisisremoteadress" + clientId);

				}
			}
		}

	}

	@OnOpen
	public void onOpen(@PathParam("clientId") String clientId, Session session) throws IOException {
		// Add session to the connected sessions set
		clients.add(session);
		System.out.println("on open call");
		if (1==1) {

			this.clientId = clientId;
			activeClients.add(this.clientId);

			if (countMap.containsKey(clientId)) {
				int count = countMap.get(clientId);
				count++;
				countMap.put(clientId, count);
			} else {
				countMap.put(clientId, 1);
			}
			for (String activeId : activeClients) {
				System.out.println("openfor" + activeId);
				for (Session client : clients) {
					
					client.getBasicRemote().sendText("openfor" + activeId);
					
				}

			}
		} else {
			try {
				session.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	@OnClose
	public void onClose(Session session) throws IOException {
		System.out.println("close event call" + clientId+"at"+new Date(System.currentTimeMillis()));
		int count = countMap.get(clientId);
		count--;
		countMap.put(clientId, count);

		if (count == 0) {
			for (Session client : clients) {

				if (!client.equals(session)) {

					client.getBasicRemote().sendText("closefor" + clientId);

				}

			}
		}
		// Remove session from the connected sessions set
		activeClients.remove(clientId);
		clients.remove(session);
	}

}
