package dom.documentsManager;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

/**
 * Test suite for document (Document) and their factory
 * 
 * @author Clasino
 *
 */
@RunWith(Suite.class)
@SuiteClasses({ ConcreteDocumentTest.class, DocumentFactoryTest.class, ConcreteAdvertisementTest.class,
	AdvertisementPointer.class })
public class AllDocumentTests {
	
}