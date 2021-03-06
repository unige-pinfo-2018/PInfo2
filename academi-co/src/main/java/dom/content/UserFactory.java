package dom.content;

import java.util.HashMap;

import dom.documentsManager.DocumentFactory;
import dom.inbox.InboxFactory;
import services.utility.ContextProvider;

/**
 * Instantiator for registered users
 * 
 * @author kaikoveritch
 *
 */
public class UserFactory {

	static public String DEFAULT_PATH = ContextProvider.getContext().getRealPath("WEB-INF/classes/defaultPP.png");
	
	static public User createUser(String username, String email, String password, String type) {
		return new ConcreteUser(username, email, password, DocumentFactory.loadDocument(DEFAULT_PATH),
				type, "", true, InboxFactory.createInbox(), new HashMap<Long, Post>(),
				new HashMap<Long, QuestionThread>());
	}
	
	static public User createUser(User user) {
		return ((ConcreteUser) user).clone();
	}
}
