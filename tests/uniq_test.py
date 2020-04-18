import unittest
from utils.uniq import uniq
from tempfile import TemporaryFile


class UniqTest(unittest.TestCase):

    def __check(self, text, expected):
        with open('.test.txt', 'w') as file:
            file.write(text)

        uniq('.test.txt', '.test.txt')

        with open('.test.txt') as file:
            actual = file.read()

        self.assertEqual(expected, actual)

    def test_delete_same_id(self):
        text = '''
        DD359621
        DD359621.1
        '''
        expected = 'DD359621'
        self.__check(text, expected)


if __name__ == '__main__':
    unittest.main()
