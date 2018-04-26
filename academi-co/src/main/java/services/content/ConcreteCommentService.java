package services.content;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceUnit;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import dom.content.Comment;
import dom.content.QuestionThread;

/**
 * Service class implementing services for comments
 * 
 * @author petrbinko
 *
 */

@Stateless
public class ConcreteCommentService implements CommentService {
	
	
	
	/******************* Attributes **********************/

	// Serial version (auto-generated)
	private static final long serialVersionUID = -1005497794725784917L;

	@PersistenceUnit(unitName="academi-co")
	private EntityManagerFactory emf;
	
	
	
	/****************** Constructors ********************/
	
	public ConcreteCommentService() {}
	
	protected ConcreteCommentService(EntityManagerFactory emf) {
		this.emf = emf;
	}
	
	
	
	/******************** Services **********************/
	
	/**
	 * Get a comment from ID
	 */
	@Override
	public Comment getComment(long id) {
		
		EntityManager entityManager = emf.createEntityManager();
		
		try {
			entityManager.getTransaction().begin();
			
			// Creating criteria builder to create a criteria query
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			
			// Criteria query of return type QuestionThread
			CriteriaQuery<Comment> criteriaQuery = criteriaBuilder.createQuery(Comment.class);
			
			
			// Roots define the basis from which all joins, paths and attributes are available in the query -> c.f. table from
			Root<Comment> variableRoot = criteriaQuery.from(Comment.class);
			
			// Condition statement -> Where
			criteriaQuery.where(criteriaBuilder.equal(variableRoot.get("ID"), id));
			
			
			// Creating typed query
			TypedQuery<Comment> query = entityManager.createQuery(criteriaQuery);
			
			// Return of single result. If we want a list of results, we use getResultList
			return query.getSingleResult();
	
		}
		finally {
			if (entityManager != null) entityManager.close();
		}
	}
	
	/**
	 * Add a comment to a question
	 */
	@Override
	public void addComment(Comment comment) {
		
		emf = Persistence.createEntityManagerFactory("academi-co");
		EntityManager entityManager = emf.createEntityManager();
		
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(comment);
			QuestionThread question = comment.getQuestion();
			question.addAnswer(comment);
			entityManager.persist(question);
			entityManager.getTransaction().commit();
		}
		finally {
			if (entityManager != null) entityManager.close();
		}
		
	}
	
	

	/****************** Getters / Setters *************/
	
	@Override
	public EntityManagerFactory getEmf() {
		return emf;
	}
	

}
