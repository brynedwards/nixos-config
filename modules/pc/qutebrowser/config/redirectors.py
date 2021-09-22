# Adapted from https://gitlab.com/jgkamat/dotfiles/blob/master/qutebrowser/.config/qutebrowser/pyconfig/redirectors.py
import operator, typing

from qutebrowser.api import interceptor, message


REDIRECT_MAP = {
    "reddit.com": operator.methodcaller("setHost", "old.reddit.com"),
}  # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]


def int_fn(info: interceptor.Request):
    """Redirect logic."""
    url = info.request_url
    if (info.resource_type != interceptor.ResourceType.main_frame) or (
        url.scheme() in {"data", "blob",}
    ):
        return
    host = url.host()
    if host[:4] == "www.":
        host = host[4:]
    redir = REDIRECT_MAP.get(host)
    if redir is not None and redir(url) is not False:
        message.info("Redirecting to " + url.toString())
        info.redirect(url)


interceptor.register(int_fn)
