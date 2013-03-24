#include <iostream>
#include <string>

using std::string;
using std::endl;
using std::cout;

template<typename T>
class SingleListNode;

template<typename T>
class SingleListNode
{
public:
    T m_data;
    SingleListNode *next;
};

template<typename T>
class SingleList 
{
public:
    // Construct of list
    SingleList();

    // Destruct of list
    ~SingleList();

    /**
     * @brif 链表结点插入
     * @param int pos 插入的位置,如果pos大于m_length则插入到链表末尾
     * @return 成功返回ture, 失败返回false 
     */
    bool insert(const T& item, int pos);

    /**
     * @brif 删除结点
     * @para 删除pos处的结点
     * @return 成功返回true, 若指定位置的结点不存在返回false
     */
    bool remove(int pos);

    /**
     * @brif 链表长度
     * @return 返回链表长度
     */
    size_t length() const;

    /**
     * @brif 返回当前结点
     * @return 返回m_curr指针指向结点
     */
    const SingleListNode<T>* current(void);

    /**
     * @brif 将m_curr移到下一结点
     */
    void next(void);

    /**
     * @brif 销毁整个链表
     */
    void destory(void);

    /**
     * @brif 打印链表
     */
    void printList(void) const;
private:
    // head node
    SingleListNode<T> * m_head;
    // current node 
    SingleListNode<T> * m_curr;

    size_t  m_length;
};

template<typename T>
SingleList<T>::SingleList()
{
    // Construct head node
    m_head = new SingleListNode<T>;
    m_head->next = NULL;
    m_curr = NULL;
    m_length = 0;
}

template<typename T>
SingleList<T>::~SingleList()
{
    SingleListNode<T> *p = m_head->next;
    while (p != NULL)
    {
        SingleListNode<T> *tmp = p;
        p = p->next;
        delete tmp;
    }

    // Release head node 
    delete m_head;
    m_head = NULL;
    m_length = 0;
    m_curr = m_head;
}

/**
 * 在位置pos后面插入结点
 * @return 成功返回true，失败返回false
 */
template<typename T>
bool SingleList<T>::insert( const T& item, int pos)
{
    if (0 == m_length) {
        // The list are empty
        m_head->m_data = item;
        m_head->next = NULL;
        // Set current node to head 
        m_curr = m_head;
        
    } else {
        // Set p point to m_head node
        SingleListNode<T> * p = m_head;

        if (pos <= 0) {
            SingleListNode<T> * tmp = new SingleListNode<T>;
            if (tmp == NULL)
                return false;
            tmp->m_data = item;
            tmp->next = p;
            // Set head node to the new node 
            m_head = tmp;
            m_curr = tmp;
        } else {
            for (int i = 1; (i < pos) && (p->next != NULL); i++ ) {
                p = p->next;
            }
            SingleListNode<T> *tmp = new SingleListNode<T>;
            if (tmp == NULL)
                return false;
            tmp->m_data = item;
            tmp->next = NULL;

            // Update current node 
            m_curr = tmp;

            if (p->next == NULL) {
                p->next = tmp;
            } else {
                // Insert in the middle of list
                tmp->next = p->next;
                p->next = tmp;
            }
        }
    }
    m_length++;
    return true;
}

/**
 * @brif 打印链表
 */
template<typename T>
void SingleList<T>::printList(void) const 
{
    SingleListNode<T> *p = m_head;
    if (m_length > 0) 
    {
        while (p != NULL) {
            cout << p->m_data << endl;
            p = p->next;
        }
    }
}

/**
 * @brif 删除结点
 * @para 删除pos处的结点
 * @return 成功返回true, 若指定位置的结点不存在返回false
 */
template<typename T>
bool SingleList<T>::remove(int pos)
{
    if (pos <= 0 || pos > m_length) 
        return false;
    SingleListNode<T> * curr = m_head;
    SingleListNode<T> * pre = NULL, *tmp = NULL;
    for (int i = 1; i < pos && curr->next != NULL; i++) {
        pre = curr;
        curr = curr->next;
    }
    // Update m_curr 
    if (m_curr == curr) {
        m_curr = curr->next;
    }
    // Delete node
    if (curr == m_head) {
        tmp = curr;
        if (m_head->next != NULL) {
            // 
            m_head = m_head->next;
            delete tmp;
        }
    } else {
        pre->next = curr->next;
        tmp = curr;
        delete tmp;
        
    }
    m_length--;
    return true;
}

/**
 * @brif 链表长度
 * @return 返回链表长度
 */
template<typename T>
size_t SingleList<T>::length() const 
{
    return m_length;
}

/**
 * @brif 返回当前结点
 * @return 返回m_curr指针指向结点
 */
template<typename T>
const SingleListNode<T>* SingleList<T>::current(void)
{
    return m_curr;
}

/**
 * @brif 销毁整个链表(除头结点外)不释放头结点内存，但头结点的数据不可访问
 */
template<typename T>
void SingleList<T>::destory(void)
{
    SingleListNode<T> * curr = m_head->next;
    while (curr != NULL)
    {
        SingleListNode<T> * tmp = curr;
        curr = curr->next;
        delete tmp;
        m_length--;
    }
    m_head->next = NULL;
    m_curr = NULL;
    m_length = 0;
}

/**
 * @brif 将m_curr移到下一结点
 */
template<typename T>
void SingleList<T>::next(void)
{
    if (m_curr->next != NULL) {
        m_curr = m_curr->next;
    }
}

int main(int argc, char **argv)
{
    int item = 100;
    SingleList<int> l;
    cout << "insert return: " << l.insert(item, 0) << endl;
    l.remove(1);
    for (int i = 0; i < 10; i++) {
        l.insert((i+1)*2-1, i);
        if (l.current() != NULL) {
            cout << "current node data:" << (l.current())->m_data;
        }
        cout << " length: " << l.length() << endl;
    }
    l.remove(4);
    l.printList();
    l.destory();
    cout << "after destory length:" << l.length() << endl;
    return 0;
}
