package services.tags;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.enterprise.inject.Alternative;

import dom.tags.MainTag;
import dom.tags.SecondaryTag;
import dom.tags.Tag;
import dom.tags.TagFactory;

/**
 * Mock of the TagService for the front-end.
 * 
 * @author kaikoveritch
 *
 */
@Alternative
@Stateless
public class FakeTagService implements TagService {

	// Serial version (auto-generated)
	private static final long serialVersionUID = -4020828114631350061L;

	@Override
	public List<MainTag> getAllSubjects() {
		List<MainTag> allSubjects = new ArrayList<MainTag>();
		for (int i = 0; i < 20; i++) {
			allSubjects.add(TagFactory.createMainTag("subject-" + i));
			for (long j = 9; j >= 0; j--) {
				SecondaryTag topic = TagFactory.createSecondaryTag("topic-" + i + "-" + j, allSubjects.get(i));
				allSubjects.get(i).getChildren().add(topic);
			}
		}
		return allSubjects;
	}

	@Override
	public Tag getLanguageTag(long id) {
		return TagFactory.createTag("Language");
	}

	@Override
	public MainTag getMainTag(long id) {
		MainTag mainTag = TagFactory.createMainTag("Subject");
		TagFactory.createSecondaryTag("topic1", mainTag);
		TagFactory.createSecondaryTag("topic2", mainTag);
		return mainTag;
	}

	@Override
	public SecondaryTag getSecondaryTag(long id) {
		MainTag parent = TagFactory.createMainTag("parent");
		SecondaryTag secondaryTag = TagFactory.createSecondaryTag("topic", parent);
		return secondaryTag;
	}

	@Override
	public Tag addTag(Tag tag) {
		return tag;
	}

	@Override
	public MainTag addTag(MainTag tag) {
		return tag;
	}

	@Override
	public SecondaryTag addTag(long parentId, SecondaryTag tag) {
		return tag;
	}

}
