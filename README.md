# KoNLPy with Mecab Docker Image
[mecab-ko](http://eunjeon.blogspot.com/)가 설치된 [KoNLPy](http://konlpy.org/en/latest/) 이미지의 `Dockerfile`입니다.

## 1. 사용법
### 1.1 이미지 생성

아래와 같이 [Github](https://github.com/hard-coders/konlpy) 저장소에서 클론한뒤 빌드하거나, 
```bash
$ git clone https://github.com/hard-coders/konlpy.git
$ cd konlpy
$ docker build .
```

아래와 같이 [DockerHub](https://cloud.docker.com/repository/docker/rurouni24/konlpy)에서 원하는 태그를 찾은뒤 pull 받으시면 됩니다.

```bash
$ docker pull rurouni24/konlpy:python3.7
```

### 1.2. 실행
모든 이미지에는 기본적으로 mecab-ko가 설치되어 있습니다.

```bash
$ docker run -it --rm rurouni24/konlpy:python3.7
Python 3.7.2 (default, Mar  5 2019, 06:22:51) 
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

`docker run` 했을 때 위와 같이 실행되면 정상적으로 이미지가 생성된 겁니다.

아래는 mecab을 이용한 예제입니다. 자세한 konlpy 사용법은
[KoNLPy](http://konlpy.org/en/latest/)를 참고하세요.
```python
>>> from konlpy.tag import Mecab
>>> mecab = Mecab()
>>> mecab.pos('안녕, 나는 미래에서 왔어')
[('안녕', 'IC'), (',', 'SC'), ('나', 'NP'), ('는', 'JX'), ('미래', 'NNG'), ('에서', 'JKB'), ('왔', 'VV+EP'), ('어', 'EC')]

```

## 2. 기타
`Dockerfile`에서 [mecab-ko](https://bitbucket.org/eunjeon/mecab-ko/downloads/)와 [mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/)의 버전을 환경변수로 조정할 수 있습니다. 아래는 그 예입니다.
```Dockerfile
# Mecab version
ENV MECAB_VERSION mecab-0.996-ko-0.9.2
ENV MECAB_DICT_VERSION mecab-ko-dic-2.1.1-20180720
ENV MECAB_PYTHON_VERSION mecab-python-0.996
```
